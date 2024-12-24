import { NextRequest, NextResponse } from "next/server";
import { Prisma } from "@prisma/client";
import prismadb from "@/lib/prismadb";
import { cookies } from 'next/headers'
import { verifyAuth } from '@/lib/auth';
import bcrypt from "bcrypt";
import moment from "moment";
import { start } from "repl";

export async function GET(req: NextRequest) { 
  try {
    let userAuth : string = "";
    let loketAuth : string = "";
    let passAuth : string = "";
    const [nopel] = req.url.split('/').slice(-1);

    const authHeader = req.headers.get('Authorization');
    const tokenHeader = authHeader?.replace("Bearer ","") || "";

    const isVerif  = await verifyAuth(tokenHeader);
    if (isVerif.status) {
      userAuth = isVerif.data?.user || "";
      loketAuth = isVerif.data?.kodeloket || "";  
      passAuth =  isVerif.data?.pass || "";     
    } else {
      return NextResponse.json(
        { success: false,
          rescode : 401,
          message: 'Screet Key failed' },
        { status: 401 }
      )     
    }

  
    const isUser =  await prismadb.users.findUnique({
      where : {
        username : userAuth,
        is_user_ppob : true,
        is_active : true
      }
    });
    
    if (!isUser) {
      return NextResponse.json(
        {
          rescode : 210,
          success : false,
          message : "User Tidak Terdaftar",
          data : {
            namauser : userAuth,
            passworduser : passAuth,
            kodeloket : loketAuth
          }
        }

        ,{status : 200})  
    }
    
    const isLoket = await prismadb.loket.findUnique({
      where : {
        kodeloket : loketAuth
      }
    })
    if (!isLoket) {
      return NextResponse.json(
        {
          rescode : 210,
          success : false,
          message : "Kode Loket Tidak Terdaftar",
          data : {
            namauser : userAuth,
            passworduser : passAuth,
            kodeloket : loketAuth
          }
        }

        ,{status : 200})  
    }
    
    
    const isUserLoket = await prismadb.user_loket.findUnique({ 
      where : {
        user_id_2 : {
          user_id : isUser.id,
          loket_id : isLoket.id
        },
      }
    })
    if (!isUserLoket) {
      return NextResponse.json(
        {
          rescode : 210,
          success : false,
          message : "Kode Loket Tidak Terdaftar",
          data : {
            namauser : userAuth,
            passworduser : passAuth,
            kodeloket : loketAuth
          }
        }

        ,{status : 200})  
    } 


    const isPassCompare = await bcrypt.compare(passAuth, isUser.password);

    if (!isPassCompare) {
      return NextResponse.json(
        {
          rescode : 210,
          success : false,
          message : "Password Tidak Valid",
          data : {
            namauser : userAuth,
            passworduser : passAuth,
            kodeloket : loketAuth
          }
        }

        ,{status : 200})  
    }     



    const isPel = await prismadb.pelanggan.findUnique({
      where : {
        no_pelanggan :  nopel || ""
      }
    })
    if (!isPel) {
      return NextResponse.json(
        {
          rescode : 211,
          success : false,
          message : "No Pelanggan Tidak Terdaftar",
          data : {
            nopel : nopel || ""
          }
        }

        ,{status : 200})  
    }

    if (isPel.status === 0) {
      return NextResponse.json(
        {
          rescode : 212,
          success : true,
          message : "No Pelanggan Non Aktif, Harap Ke Kantor PDAM",
          data : {
            nopel : nopel || "" 
          }
        }

        ,{status : 200})        
    }
    

    // const formatdate=formatter.format(new Date());\
    const currentDate = new Date();
    const mom = moment.utc(`${currentDate}+07:00`).format();
    const currentDateFix = new Date(mom.slice(0,10))

    const cutoff = await prismadb.cutoff_ppob.findFirst(
      {
        where : {
          start : {
            lte : currentDateFix
          },
          end : {
            gte : currentDateFix
          }
        }
      }
    )

    if (cutoff) {
      return NextResponse.json(
        {
          rescode : 299,
          success : false,
          message : "Saat Ini Sedang Masa Cutoff",
          data : {
            nopel : nopel || ""
          }
        }

        ,{status : 200})  
    }

    console.log(cutoff);
    const datatagihan : any[] = await prismadb.$queryRaw(
      Prisma.sql`call infotag(${nopel})` 
    )
    console.log(datatagihan)   
    if (!datatagihan || datatagihan.length === 0) {
      return NextResponse.json(
        {
          rescode : 215,
          success : false,
          message : "Tagihan Sudah Lunas",
          data : {
            nopel : nopel || ""
          }
        }

        ,{status : 200})  
    }


    // let dataTagihanSum =  [];

    // for (const dataTag of datatagihan) {
    //   const total = dataTag.f31;
    //   const nosamb = dataTag.f1;
    //   const dendatunggakan = dataTag.f29;
    //   const total = dataTag.f31;
    //   const kode = `${dataTag.f5}.${dataTag.f1}`;
    //   const periode = dataTag.f5; 
    //   console.log(kode);
    //   try {
        
    //     const isBayar : any [] = await prismadb.$queryRaw(
    //       Prisma.sql`call bayar_coklit(${userAuth},${passAuth},${loketAuth},${totalBayar},${nosamb},${dendatunggakan},${total},${kode},${periode})` 
    //     )

    //     if (isBayar[0].f0 ==="015") {
        
    //       const dumpDt = {
    //         periode : periode,
    //         status : "OK"
    //       }
    //       dataStsBayar.push(dumpDt)
    //     } else {
    //       const dumpDt = {
    //         periode : periode,
    //         status : "GAGAL"
    //       }
    //       dataStsBayar.push(dumpDt);
    //     }

    //   } catch (error) {
    //     const dumpDt = {
    //       periode : periode,
    //       status : "ERROR"
    //     }   
    //     dataStsBayar.push(dumpDt);     
    //   }      
    // }
    // datatagihan.reverse()
    // console.log(datatagihan);
    let periode = ""
    if (datatagihan.length > 1) {
      periode = `${datatagihan[0].f2} - ${datatagihan[datatagihan.length-1].f2}`;
    } else {
      periode = `${datatagihan[0].f2}`;
    }

    const  golongan = datatagihan[datatagihan.length-1].f6;
    const  stanlalu = datatagihan[0].f8;
    const  stanini  = datatagihan[datatagihan.length-1].f9;
    let  pakaim3  = 0;
    let  hargaair  = 0;

    let  administrasi  = 0;
    let  angsuran  = 0;
    let  materai  = 0;
    let  pemeliharaan  = 0;
    let retribusi  = 0;
    let  denda  = 0;
    let  total  = 0;

    datatagihan.forEach(val => {

        pakaim3 += parseInt(val.f10),
        hargaair += parseInt(val.f11),
        administrasi += parseInt(val.f13)+parseInt(val.f22),
        pemeliharaan += parseInt(val.f14),
        retribusi+= parseInt(val.f15),
        angsuran += parseInt(val.f17),
        denda += parseInt(val.f23)+parseInt(val.f24),
        materai += parseInt(val.f25),
        total += parseInt(val.f26)

    })

    const resultDataTag =  {
        periode : periode,
        golongan : golongan,
        stanlalu : stanlalu,
        stanini : stanini,
        pakaim3 : pakaim3,
        hargaair : hargaair,
        administrasi : administrasi,
        pemeliharaan : pemeliharaan,
        retribusi : retribusi,
        angsuran : angsuran,
        denda : denda,
        materai : materai,
        total : total      
    }

    const result = 
    {
      rescode : 200,
      success : true,
      message : "Tagihan Tersedia",
      data : {
        no_pelanggan : isPel.no_pelanggan.trim(),
        nama : isPel.nama?.trim(),
        alamat : isPel.alamat?.trim(),
        tagihan : resultDataTag
      }
    }



    return NextResponse.json(result,{status : 200})   

  } catch (error) {
    return NextResponse.json({
      rescode : 500,
      success : false,
      message : `General Error : ${error}`
    }, { status: 500 })
  }


}

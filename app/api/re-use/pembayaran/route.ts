import { NextRequest, NextResponse } from "next/server";
import { Prisma } from "@prisma/client";
import prismadb from "@/lib/prismadb";
import { cookies } from 'next/headers'
import { verifyAuth } from '@/lib/auth';

import bcrypt from "bcrypt";
export const maxDuration = 30; // This function can run for a maximum of 5 seconds
export const dynamic = 'force-dynamic';
 
export async function POST(req: NextRequest) { 
  try {
    const body = await req.json();

    let userAuth : string = "";
    let loketAuth : string = "";
    let passAuth : string = "";

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
       // cek user verifikasi
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


    const isPassCompare =  bcrypt.compareSync(passAuth, isUser.password);

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

    
    if (!Array.isArray(body.periode) || !body.no_pelanggan)  {
      return NextResponse.json(
        { 
          rescode : 310,
          success: false,
          message: 'Data Body Invalid' },
        { status: 200 }
      )         
    }

    const isPel = await prismadb.pelanggan.findUnique({
      where : {
        no_pelanggan :  body.no_pelanggan || "",
      }
    })
    if (!isPel) {
      return NextResponse.json(
        {
          rescode : 211,
          success : false,
          message : "No Pelanggan Tidak Terdaftar",
          data : {
            nopel : body.no_pelanggan || "" 
          }
        }

        ,{status : 200})  
    }
    if (isPel.status === 0) {
      return NextResponse.json(
        {
          rescode : 212,
          success : false,
          message : "No Pelanggan Non Aktif, Harap Ke Kantor PDAM",
          data : {
            nopel : body.no_pelanggan || "" 
          }
        }

        ,{status : 200})        
    }
    
    const tglnow : string = new Date().toLocaleDateString('en-ZA');   

    const datatagihan : any[] = await prismadb.$queryRaw(
      Prisma.sql`call infotag_desk(${body.no_pelanggan},${tglnow})` 
    )
    // console.log(datatagihan)   
    if (!datatagihan || datatagihan.length === 0) {
      return NextResponse.json(
        {
          rescode : 215,
          success : false,
          message : "Tagihan Sudah Lunas",
          data : {
            nopel : body.no_pelanggan || ""
          }
        }

        ,{status : 200})  
    }

    const jmlperiode = body.periode.length;
    const jmldataTagihan = datatagihan.length;
    if (jmldataTagihan !== jmlperiode) {
      return NextResponse.json(
        {
          rescode : 311,
          success : false,
          message : "Jumlah Periode Tagihan Invalid",
          data : {
            periode : body.periode 
          }
        }

        ,{status : 200})  

    }

    const periodeTagihan = datatagihan.map(val => {
      return val.f2;
    })

    const periodeBody = body.periode;
    periodeBody.sort();
    periodeTagihan.sort();
    const isMatchPeriodeData = (JSON.stringify(periodeBody) === JSON.stringify(periodeTagihan));
    if (!isMatchPeriodeData) {
      return NextResponse.json(
        {
          rescode : 312,
          success : false,
          message : "Data Periode Tagihan Invalid",
          data : {
            periode : periodeBody
          }
        }

        ,{status : 200})  
    }
    // let periode = ""
    // if (datatagihan.length > 1) {
    //   periode = `${datatagihan[0].f2} - ${datatagihan[datatagihan.length-1].f2}`;
    // } else {
    //   periode = `${datatagihan[0].f2}`;
    // }
    // const  golongan = datatagihan[datatagihan.length-1].f6;
    // const  stanlalu = datatagihan[0].f8;
    // const  stanini  = datatagihan[datatagihan.length-1].f9;    
    // let  pakaim3  = 0;
    // let  hargaair  = 0;
    // let  administrasi  = 0;
    // let  angsuran  = 0;
    // let  materai  = 0;
    // let  pemeliharaan  = 0;
    // let retribusi  = 0;
    // let  denda  = 0;
    // let  total  = 0;

    // datatagihan.forEach(val => {

    //     pakaim3 += parseInt(val.f10),
    //     hargaair += parseInt(val.f11),
    //     administrasi += parseInt(val.f13)+parseInt(val.f22),
    //     pemeliharaan += parseInt(val.f14),
    //     retribusi+= parseInt(val.f15),
    //     angsuran += parseInt(val.f17),
    //     denda += parseInt(val.f23)+parseInt(val.f24),
    //     materai += parseInt(val.f25),
    //     total += parseInt(val.f26)

    // })
    // if (total !== body.totaltagihan) {
    //   return NextResponse.json(
    //     {
    //       rescode : 315,
    //       success : false,
    //       message : "Total Tagihan Tidak Valid",
    //       data : {
    //         nopel : body.no_pelanggan || "",
    //         totaltagihan : body.totaltagihan
    //       }
    //     }

    //     ,{status : 200})  
    // }
    

    let dataStsBayar =  [];
    let dataResBayar : any =  [];

    const tgl : any = await prismadb.$queryRaw`Select now() as tgl`;

    // console.log(tgl);

    for (const dataTag of datatagihan) {
      const dendatunggakan = parseInt(dataTag.f23)+parseInt(dataTag.f24);
      const total = parseInt(dataTag.f27);
      const materai = parseInt(dataTag.f26);
      const admin_ppob= 0; 
      const idRek = parseInt(dataTag.f0);
      const periode = dataTag.f2; 
      //  console.log(idRek);
      try {

        const isBayar : number = await prismadb.$executeRaw`UPDATE drd SET flaglunas=1,tglbayar=${tgl[0].tgl},user_id=${isUser.id},nama_user=${isUser.nama},loket_id=${isUserLoket.loket_id},nama_loket=${isLoket.kodeloket},denda=${dendatunggakan},meterai=${materai},admin_ppob=${admin_ppob},totalrekening=${total} WHERE id=${idRek}`;

        // console.log(isBayar)

        // update
        if (isBayar === 1) {
          dataStsBayar.push(0)
          dataResBayar.push({periode : periode,sts : 'sukses'});
        } else {
          dataResBayar.push({periode : periode,sts : 'Gagal'});    
          dataStsBayar.push(1);
        }

      } catch (error) {
        console.log(error)
        dataStsBayar.push(1); 
        dataResBayar.push({periode : periode,sts : 'Gagal'});        
      }      
    }

    const sumSukses = dataStsBayar.reduce((x,y) => {
      return x+y
    },0);

    if (sumSukses > 0 ) {
      for (const dataTag of datatagihan) {
        const idRek = parseInt(dataTag.f0);
        try {

          const isBayar : number = await prismadb.$executeRaw`UPDATE drd SET flaglunas=0,tglbayar=null,user_id=null,nama_user=null,loket_id=null,nama_loket=null,denda=0,meterai=0,admin_ppob=0,totalrekening=0 WHERE id=${idRek} `;

        } catch (error) {
          return NextResponse.json({
            rescode : 500,
            success : false,
            message : `General Error : ${error}`
          }, { status: 500 })
        }   

      }
      return NextResponse.json({
        rescode : 399,
        success : false,
        message : "Pembayaran Gagal",
      }, { status: 200 }) 

    }


    const result = 
    {
      rescode : 300,
      success : true,
      message : "Pembayaran Sukses",
      data : {
        no_pelanggan : isPel.no_pelanggan,
        tgl_bayar : tgl[0].tgl,
        nama : isPel.nama?.trim(),
        alamat : isPel.alamat?.trim(),
        tagihan : dataResBayar
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

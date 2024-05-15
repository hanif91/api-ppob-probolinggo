import { NextRequest, NextResponse } from "next/server";
import { Prisma } from "@prisma/client";
import prismadb from "@/lib/prismadb";
import { cookies } from 'next/headers'
import { verifyAuth } from '@/lib/auth';
import bcrypt from "bcrypt";

function isValidDate( dt : any ) {
  if (Object.prototype.toString.call(dt) === 
  "[object Date]") {
      if (isNaN(dt.getTime())) {
          return false;
      }
      else {
          return true;
      }
  }
}

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

    if (!body.startdate || !body.enddate || !body.data)  {
      return NextResponse.json(
        { 
          rescode : 610,
          success: false,
          message: 'Data Body Invalid' },
        { status: 200 }
      )         
    }
    
    if (!Array.isArray(body.data)) {
      return NextResponse.json(
        { 
          rescode : 610,
          success: false,
          message: 'Data Body Array Invalid' },
        { status: 200 }
      )           
    }

  

    const dateStart = new Date(body.startdate);
    const dateEnd = new Date(body.enddate);
    const isValidStartDate : boolean = isValidDate(dateStart) || false;
    const isValidEndDate : boolean = isValidDate(dateEnd) || false;

    if (!isValidStartDate || !isValidEndDate) {
      return NextResponse.json(
        { 
          rescode : 610,
          success: false,
          message: 'Data Tanggal Invalid' },
        { status: 200 }
      )    

    }


    const isInsRekon =  await prismadb.rekon_mitra.create({
      data : {
        startdate : dateStart,
        enddate : dateEnd,
        user_id : isUser.id,
        namauser : isUser.nama,
        data : body.data   
      }
    })

    if (!isInsRekon) {
      return NextResponse.json(
        { 
          rescode : 620,
          success: false,
          message: 'Upload Data Rekon gagal' },
        { status: 200 }
      )   
    }

    console.log(isInsRekon)
    return NextResponse.json(
      { 
        rescode : 600,
        success: true,
        message: 'Upload Data Rekon Berhasil' }
      ,{status : 200})   


  } catch (error) {
    return NextResponse.json({
      rescode : 500,
      success : false,
      message : `General Error : ${error}`
    }, { status: 500 })
  }


}

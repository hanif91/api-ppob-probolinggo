import Image from 'next/image'

export default function Home() {
  const res =  {
    app : "Api PPOB Perumda Air Minum Bayuangga Kota Probolinggo",
    versi : "Versi 1.0"
  }

  const result = JSON.stringify(res);
  return (result)
}

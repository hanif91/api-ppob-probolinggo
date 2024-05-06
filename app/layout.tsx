export const metadata = {
  title: 'Api Perumda Air Minum Bayuangga Kota Probolinggo',
  description: 'Api Perumda Air Minum Bayuangga Kota Probolinggo',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}

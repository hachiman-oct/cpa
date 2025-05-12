Add-Type -AssemblyName System.Drawing

# 設定
$width = 256
$height = 256
$text = "AU"
$fontName = "Arial"
$fontSize = 90
$textColor = [System.Drawing.Color]::Blue
$transparentColor = [System.Drawing.Color]::FromArgb(0, 255, 255, 255)  # 完全透明

# ピクセル形式を定義（Format32bppArgb）
$pixelFormat = [System.Drawing.Imaging.PixelFormat]::Format32bppArgb

# Bitmapを作成（透過対応）
$bitmap = [System.Drawing.Bitmap]::new($width, $height, $pixelFormat)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

# 背景を透明に
$graphics.Clear($transparentColor)

# アンチエイリアス
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

# フォントを生成（FontStyleも変数で渡す）
$fontStyle = [System.Drawing.FontStyle]::Regular
$font = [System.Drawing.Font]::new($fontName, $fontSize, $fontStyle)

# テキスト描画位置の設定
$brush = [System.Drawing.SolidBrush]::new($textColor)
$stringFormat = [System.Drawing.StringFormat]::new()
$stringFormat.Alignment = 'Center'
$stringFormat.LineAlignment = 'Center'

$rect = [System.Drawing.RectangleF]::new(0, 0, $width, $height)

# 描画
$graphics.DrawString($text, $font, $brush, $rect, $stringFormat)

# ファイルに保存
$outputPath = "$PWD\$text.png"
$bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

# 解放
$graphics.Dispose()
$bitmap.Dispose()

Write-Output "✅ 透過PNGを保存しました: $outputPath"

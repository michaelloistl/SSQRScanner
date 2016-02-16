Pod::Spec.new do |s|
s.name     = "SSQRScanner"
s.version  = "1.0.0"
s.platform = :ios, "9.0"
s.license  = { :type => 'MIT' }
s.summary  = 'QR Code Scanner'
s.homepage = 'https://github.com/SSamanta/'
s.authors  = { 'Susim' => 'susim.samanta@me.com' }
s.source   = { :git => "https://github.com/SSamanta/SSQRScanner.git", :branch => "master", :tag => "v1.0.0"  }
s.source_files = 'SSQRCodeScanner/SSQRCodeScanner/SSQRScanner.{swift}'
s.requires_arc = true
end
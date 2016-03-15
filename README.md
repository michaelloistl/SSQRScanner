**SSQRCodeScanner** is simple reusable components in IOS developed using swift language. Using this component you can simply integrate **QR Code** scanner into your app.

It's available in **pods** also.

`pod 'SSQRScanner'`

**Sample Code :**

`import SSQRCodeScanner`

    func loadQRCodeScanner() {
        self.qrScanner = SSQRScanner()
        self.qrScanner!.createQRScannerOnCompletion(self.view, scannerHandler: {[weak self] (obj, error) -> Void in
            if((obj) != nil) {
                if self != nil {
                    let result = obj as! String
                    print(result)
                }
            }
            if((error) != nil) {
                print(error)
            }
       })
    }

**Don't like Pods?**

**Option 1:** You can download Github repo and build it. You can us .framework file into your code.

**Option 2 :** Simple Copy paste "`SSQRScanner.swift`" file into your code.

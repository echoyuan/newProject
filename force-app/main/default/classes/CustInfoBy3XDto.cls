public class CustInfoBy3XDto {
    //お客さま番号
    public String custNo { get; set; }
    //店名屋号
    public String shopNameOfKanji { get; set; }
    //店名屋号（カナ）    
    public String shopNameOfKana { get; set; }
    //おなまえ    
    public String nameOfKanji { get; set; }
    //おなまえ（カナ）   
    public String nameOfKana { get; set; }
    //住所   
    public String address { get; set; }
    //郵便番号
    public String PostalNum { get; set; }
    //電話番号リスト
    public List< Phone> phoneList { get; set; }
    
    public CustInfoBy3XDto custInfo { get; set; }
    
    private class Phone {
        //電話番号
        //電話種別
        //電話種別（デコード）
        //電話連絡先種別
        //電話連絡先種別（デコード）
        //電話利用識別
        //電話利用識別（デコード）
        
        private String phoneNo;
        private String phoneType;
        private String phoneTypeDecode;
        private String phoneContractType;
        private String phoneContractTypeDecode;
        private String phoneId;
        private String phoneIdDecode;
        
        private Phone(String phoneNo, String phoneType, String phoneTypeDecode,
                      String phoneContractType, String phoneContractTypeDecode,
                      String phoneId, String phoneIdDecode) {
                          phoneNo = phoneNo;
                          phoneType = phoneType;
                          phoneTypeDecode = phoneTypeDecode;
                          phoneContractType = phoneContractType;
                          phoneContractTypeDecode = phoneContractTypeDecode;
                          phoneId = phoneId;
                          phoneIdDecode = phoneIdDecode;
                      }
    }  
}
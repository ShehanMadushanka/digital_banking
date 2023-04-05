package external;

import com.google.gson.Gson;
import com.mastercard.mpqr.pushpayment.model.PushPaymentData;
import com.mastercard.mpqr.pushpayment.model.AdditionalData;
import com.mastercard.mpqr.pushpayment.model.UnrestrictedData;
import com.mastercard.mpqr.pushpayment.parser.Parser;

public class LankaQRScanner {
    public  static String LQRErrorCode = "LQRError";
    public  static String InvalidLQR = "Invalid QR";

    public static String getLankaQRData(String qrString){
        LankaQRPayload lankaQRPayload = new LankaQRPayload();
        AdditionalData additionalData = null;
        UnrestrictedData unrestrictedData = null;
        
        try{
            PushPaymentData qrdata = parseQRCode(qrString);
            try{
                additionalData = qrdata.getAdditionalData();

                lankaQRPayload.setPointOfInitiationMethod(qrdata.getPointOfInitiationMethod());

                if(additionalData != null){
                    try{
                        lankaQRPayload.setReferenceId(additionalData.getReferenceId() != null &&  !additionalData.getReferenceId().equals("***")? additionalData.getReferenceId() : "");
                    }catch(Exception e){}
                    try{
                        lankaQRPayload.setBillNumber(additionalData.getBillNumber() != null ? additionalData.getBillNumber() : "");
                    }catch(Exception e){}
                    try{
                        lankaQRPayload.setMobileNumber(additionalData.getMobileNumber() != null ? additionalData.getMobileNumber() : "");
                    }catch(Exception e){}
                    try{
                        lankaQRPayload.setStoreId( additionalData.getStoreId() != null ? additionalData.getStoreId() : "");
                    }catch(Exception e){}
                    try{
                        lankaQRPayload.setLoyaltyNumber(additionalData.getLoyaltyNumber() != null ? additionalData.getLoyaltyNumber() : "");
                    }catch(Exception e){}
                    try{
                        lankaQRPayload.setTerminalId(additionalData.getTerminalId() != null ? additionalData.getTerminalId() : "");
                    }catch(Exception e){}
                }
            }catch(Exception e){}
            try{
                lankaQRPayload.setTransactionFee(qrdata.getTransactionAmount());
            }catch(Exception e){}
            try{
                lankaQRPayload.setMerchantCity(qrdata.getMerchantCity() != null ? qrdata.getMerchantCity() : "");
            }catch(Exception e){}
            try{
                lankaQRPayload.setMerchantName(qrdata.getMerchantName() != null ? qrdata.getMerchantName() : "");
            }catch(Exception e){}
            try{
                lankaQRPayload.setTipOrConFeeIndicator(qrdata.getTipOrConvenienceIndicator() != null ? qrdata.getTipOrConvenienceIndicator() : "");
            }catch(Exception e){}
            try{
                lankaQRPayload.setConvenienceFee(qrdata.getValueOfConvenienceFeeFixed());
            }catch(Exception e){}
            try{
                lankaQRPayload.setConveniencePercentage(qrdata.getValueOfConvenienceFeePercentage());
            }catch(Exception e){}
            try {
                lankaQRPayload.setQrMAIData(qrdata.getMAIData("26").getAID());
            } catch (Exception tag26error) {
                lankaQRPayload.setQrMAIData(qrdata.getMAIData("27").getAID());
            }

            try{
                unrestrictedData = qrdata.getUnrestrictedData("85");
                if(unrestrictedData != null){
                    lankaQRPayload.setUnrestrictedTag85String(unrestrictedData.toString());
                }
            }catch(Exception e){}
            
            return new Gson().toJson(lankaQRPayload);
        }catch (Exception e){
            return LQRErrorCode;
        }
    }

    private static PushPaymentData parseQRCode(String code) {
        PushPaymentData qrcode = null;
        try {
            qrcode = Parser.parseWithoutTagValidation(code);
            qrcode.validate();
        } catch (Exception e) {

        }
        return qrcode;
    }
}

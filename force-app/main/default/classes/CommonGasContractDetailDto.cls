public class CommonGasContractDetailDto {
   // お客さま情報API
   @AuraEnabled public CommonGasAccountResponseDto gasAccountResponseDto { get; set; }
   // 支払情報API
   @AuraEnabled public List<CommonGasPaymentResponseDto> gasPaymentResponseDtoList { get; set; }
   // ガス契約情報API
   @AuraEnabled public List<CommonGasContractResponseDto> gasContractResponseDtoList { get; set; }
   // メータ状態取得API
   @AuraEnabled public List<CommonGasMeterResponseDto> gasMeterResponseDtoList { get; set; }
   // 電気料金合算パターン情報API
   @AuraEnabled public CommonGasElectricAddPatternResponseDto gasElectricAddPatternResponseDto { get; set; }
   // 接客履歴情報API
   @AuraEnabled public List<CommonGasReceiveHistoryResponseDto> gasReceiveHistoryResponseDtoList { get; set; }
   // ガス関連番号API???
   @AuraEnabled public CommonGasSpecialResponseDto gasSpecialResponseDto { get; set; }
   // ガスメータ設置場所情報API
   @AuraEnabled public List<CommonGasMeterSetResponseDto> gasMeterSetResponseDtoList { get; set; }


    public CommonGasContractDetailDto() {
	}
   
}
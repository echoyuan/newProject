public class CommonApiRequestElDetail {
    public Integer statusCode { get; set; }
    public String errorCode { get; set; }
    public String errorMessage { get; set; }
    public CommonResponseElContractDetailDto contract { get; set; }

    private HttpRequest request = null;
    private HttpResponse response = null;

    private final Map<String, String> SERVICE_NAME =
        new Map<String, String> {
            '001' => 'ガス',    // ガス：ガス使用契約番号(ガス4x)
                '006' => '電気',    // 電気：電力契約番号(SA)
                '009' => 'myTOKYOGAS',    // myTOKYOGAS：会員ID
                '010' => '域外ガス',    // 域外ガス：お客さま登録番号(3x)
                '008' => '駆け付け',    // 駆け付けサービス：駆け付けサービスID
                '007' => 'トリプル',    // 光通信：光サービスID
                '012' => '有償メンテ',    // 有償メンテ：有償メンテID(仮)
                '002' => 'くらし見守り',    // くらし見守り：くらし見守りID(仮)
                '004' => '警報機リース',    // 警報器リース：警報器リースID(仮)
                '003' => 'TESメンテ'     // ＴＥＳメンテナンス：ＴＥＳメンテナンスID(仮)
                };

    private final Map<String, String> SERVICE_STATUS =
		new Map<String, String> {
        	'01' => '提供未',
            '02' => '提供中',
            '03' => '停止中',
            '04' => '解約'
		};

    public CommonApiRequestElDetail() {
        request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://tgcrm.azure-api.net/demo/v1/4xContractDetail');
	}
    
    public void send(String serviceKey) {
        String body = getRequestBody(serviceKey);
        request.setHeader('Content-type', 'application/json; charset=utf-8');
        request.setHeader('Content-Length', String.valueOf(body.length()));
        request.setHeader('Ocp-Apim-Subscription-Key', 'c4d26d894c584b53b4bb30e105aec154');
        request.setBody(body);
        Http http = new Http();
        response = http.send(request);
        System.debug(Logginglevel.INFO, 'response code:' + response.getStatusCode());
        System.debug(Logginglevel.INFO, 'response body:' + response.getBody());
        statusCode = response.getStatusCode();
        if (statusCode == 200) {
            setResponseData(response.getBody());
        } else {
            // ToDo: 例外レスポンス処理詳細化
            errorMessage = response.getBody();
        }
    }

    private String getRequestBody(String serviceKey) {
        String body = '';
        // debug mode only : true
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('keys', serviceKey);
        gen.writeEndObject();
        System.debug(Logginglevel.INFO, 'request body:' + gen.getAsString());
        
        return body;
    }

    private void setResponseData(String body) {
        JSONParser parser = JSON.createParser(body);
        ResponseData data = (ResponseData) parser.readValueAs(ResponseData.class);
        if (data == null) {
            errorMessage = 'レスポンスフォーマット例外';
            return;
        }
        if (data.error != null && data.error.errorCode != null) {
            errorCode = data.error.errorCode;
            errorMessage = data.error.message;
            return;
        }
        if (data.service != null
            && data.service.customer != null
            && data.service.detail != null) {
                contract = new CommonResponseElContractDetailDto();
                //contract.customerNumber = data.service.customer.customerNumber;
                //contract.storeName = data.service.customer.storeName;
                //contract.name = data.service.customer.name;
                //contract.address = data.service.customer.address;
                //contract.postal = data.service.customer.postal;
                //contract.systemProcCode = data.service.customer.systemProcCode;
                //contract.storeNameKana = data.service.customer.storeNameKana;
                //contract.nameKana = data.service.customer.nameKana;
                //contract.phone = data.service.customer.phone;
                
                //contract.managementBranch = data.service.detail.managementBranch;
                //contract.paymentMethod = data.service.detail.paymentMethod;
                //contract.financialInstitution = data.service.detail.financialInstitution;
                //contract.depojistType = data.service.detail.depojistType;
                //contract.payerName = data.service.detail.payerName;
                //contract.cardCompany = data.service.detail.cardCompany;
                //contract.gasPriceContractType = data.service.detail.gasPriceContractType;
                //contract.paymentMeterReading = data.service.detail.paymentMeterReading;
                //contract.gasMeterCompanyNumber = data.service.detail.gasMeterCompanyNumber;
                //contract.meterPosition = data.service.detail.meterPosition;
                //contract.meterState = data.service.detail.meterState;
                //contract.supplyStopMethod = data.service.detail.supplyStopMethod;
                //contract.recentMeterReadingDay = data.service.detail.recentMeterReadingDay;
                //contract.currentBillingStatus = data.service.detail.currentBillingStatus;
                //contract.otherSystemContractInformation = data.service.detail.otherSystemContractInformation;
                //contract.electricPowerSum = data.service.detail.electricPowerSum;
                //contract.responseAttention = data.service.detail.responseAttention;
                //contract.administrativeDistrict = data.service.detail.administrativeDistrict;
                //contract.designationDateTransfer = data.service.detail.designationDateTransfer;
                //contract.branchName = data.service.detail.branchName;
                //contract.accountNumber = data.service.detail.accountNumber;
                //contract.billingService = data.service.detail.billingService;
                //contract.cardExpirationDate = data.service.detail.cardExpirationDate;
                //contract.amountDesignationReport = data.service.detail.amountDesignationReport;
                //contract.nextMonthTotal = data.service.detail.nextMonthTotal;
                //contract.formatNumberItems = data.service.detail.formatNumberItems;
                //contract.terminationReason = data.service.detail.terminationReason;
                //contract.meterReadingReason = data.service.detail.meterReadingReason;
                //contract.responseBillding = data.service.detail.responseBillding;
                //contract.meterReadingMethod = data.service.detail.meterReadingMethod;
                //contract.meterReadingTimes = data.service.detail.meterReadingTimes;
                //contract.cardNumber = data.service.detail.cardNumber;
                //contract.ghpState = data.service.detail.ghpState;
                //contract.previousAddressCustomerNumber = data.service.detail.previousAddressCustomerNumber;
                //contract.instructionNumber = data.service.detail.instructionNumber;
            }
    }

    private String getServiceStatus(List<Transfer> transfers) {
        // ToDo: 日付の参照と仕様確認
        String serviceStatus = '';
        if (transfers == null) {
            return serviceStatus;
        }
        Map<String, String> transferMap = new Map<String, String>();
        for (Transfer transfer : transfers) {
            transferMap.put(transfer.transferType, transfer.transferYmd);
        }
        if (transferMap.containsKey('04')) {
            serviceStatus = '04';
        } else if (transferMap.containsKey('03')) {
            serviceStatus = '03';
        } else if (transferMap.containsKey('02')) {
            serviceStatus = '02';
        } else if (transferMap.containsKey('01')) {
            serviceStatus = '01';
        }
        return serviceStatus == null ? '-' : SERVICE_STATUS.get(serviceStatus);
    }

    private class ResponseData {
        private Service service;
        private Error error;

        private ResponseData(Service service, Error error) {
            service = service.clone();
            error = error.clone();
        }
    }

    private class Error {
        private String statusCode;
        private String errorCode;
        private String message;

        private Error(String statusCode, String errorCode, Service message) {
            statusCode = statusCode;
            errorCode = errorCode;
            message = message;
        }
    }

    private class Service {
        private String serviceId;
        private String serviceType;
        private List<Role> roles;
        private List<Transfer> transfers;
        private Customer customer;
        private Detail detail;

        private Service(String serviceId, String serviceType, List<Role> roles, List<Transfer> transfers,
                Customer customer, Detail detail) {
            serviceId = serviceId;
            serviceType = serviceType;
            roles = roles.clone();
            transfers = transfers.clone();
            customer = customer.clone();
            detail = detail.clone();
        }
    }

    private class Role {
        private String roleType;
        private String transferYmd;

        private Role(String roleType, String transferYmd) {
            roleType = roleType;
            transferYmd = transferYmd;
        }
    }

    private class Transfer {
        private String transferType;
        private String transferYmd;

        private Transfer(String transferType, String transferYmd) {
            transferType = transferType;
            transferYmd = transferYmd;
        }
    }

    private class Customer {
        private String customerNumber;
        private String storeName;
        private String name;
        private String address;
        private String postal;
        private String systemProcCode;
        private String storeNameKana;
        private String nameKana;
        private String phone;

        private Customer(String customerNumber, String storeName, String name, String address, String postal,
                String systemProcCode, String storeNameKana, String nameKana, String phone) {

            this.customerNumber = customerNumber;
            this.storeName = storeName;
            this.name = name;
            this.address = address;
            this.postal = postal;
            this.systemProcCode = systemProcCode;
            this.storeNameKana = storeNameKana;
            this.nameKana = nameKana;
            this.phone = phone;
        }
    }

    private class Detail {
        private String managementBranch;
        private String paymentMethod;
        private String financialInstitution;
        private String depojistType;
        private String payerName;
        private String cardCompany;
        private String gasPriceContractType;
        private String paymentMeterReading;
        private String gasMeterCompanyNumber;
        private String meterPosition;
        private String meterState;
        private String supplyStopMethod;
        private String recentMeterReadingDay;
        private String currentBillingStatus;
        private String otherSystemContractInformation;
        private String electricPowerSum;
        private String responseAttention;
        private String administrativeDistrict;
        private String designationDateTransfer;
        private String branchName;
        private String accountNumber;
        private String billingService;
        private String cardExpirationDate;
        private String amountDesignationReport;
        private String nextMonthTotal;
        private String formatNumberItems;
        private String terminationReason;
        private String meterReadingReason;
        private String responseBillding;
        private String meterReadingMethod;
        private String meterReadingTimes;
        private String cardNumber;
        private String ghpState;
        private String previousAddressCustomerNumber;
        private String instructionNumber;
    }
}
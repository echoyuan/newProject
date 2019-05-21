<aura:application implements ="lightning:isUrlAddressable,force:appHostable" access="global" controller="RedirectToAccountDetailController" extends="force:slds"> 
    <aura:attribute name="meter" type="String"/>
    <aura:attribute name="customer" type="String"/>
    <aura:attribute name="gascontract" type="String"/>
    <aura:attribute name="showButtonFlg" type="Boolean" default="true"/>
    
    <aura:handler name="init" action="{!c.doInit}" value="{!this}" />
    <div>
        <div class="slds-modal__content slds-p-around_medium successArea" id="modal-content-id-1">
            <aura:if isTrue="{!v.errorFlg}">
                <div class="slds-text-color--error error-margin-left">
                    <ul class="errorsList">
                        <li>{!$Label.c.SYSTEM_ERROR_MESSAGE}</li>
                    </ul>
                </div>
            </aura:if>							
            <aura:if isTrue="{!v.infoFlg}">
                <div class="slds-text-color--error error-margin-left">
                    <ul class="errorsList">
                        {!v.infoMsg}
                    </ul>
                </div>
            </aura:if>
            <aura:if isTrue="{!v.showButtonFlg}">
                <lightning:button label="GO!" onclick="{!c.goAccountSearch}" class="slds-button slds-button--brand slds-m-right_x-small"/>
            </aura:if> 
        </div>
    </div>
</aura:application>


<!--<aura:application access="GLOBAL" extends="ltng:outApp" 
    implements="ltng:allowGuestAccess">
    <aura:dependency resource="c:storeLocatorMain"/>
    <script>
    $Lightning.use("c:RedirectToAccountDetail",    // name of the Lightning app
        function() {                  // Callback once framework and app loaded
            $Lightning.createComponent(
                "c:storeLocatorMain", // top-level component of your app
                { },                  // attributes to set on the component when created
                "lightningLocator",   // the DOM location to insert the component
                function(cmp) {
           alert('1');
                    // callback when component is created and active on the page
                }
            );
        },
        'https://universalcontainers.force.com/ourstores/'  // Community endpoint
    );
</script>
</aura:application>-->
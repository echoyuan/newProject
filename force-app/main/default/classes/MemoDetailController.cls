global class MemoDetailController {
    
    private static final String PRE_TITLE = '【ホーム】お知らせ%';
    private static final String MESSAGE = 'お知らせはありません';
    
    @AuraEnabled
    public static CommonResponseDto getMemoInfo() {
        try {
            //ユーザを取得
            List<User> users = getSystemAndManagerUsers();
            if (users != null && !users.isEmpty()) {
                List<Id> ids = new List<Id>();
                for (user u : users) { 
                    ids.add(u.Id);
                }
                System.debug('ids='+ids);
                if (!ids.isEmpty()) {
                    List<ContentDocumentLink> documentLinks = [SELECT id, ContentDocumentId, LinkedEntityId, shareType, Visibility 
                                                               FROM ContentDocumentLink WHERE ContentDocument.FileType = 'SNOTE' 
                                                               AND ContentDocument.Title LIKE :PRE_TITLE AND LinkedEntityId in : ids
                                                               Order by ContentDocument.LastModifiedDate Desc Limit 1];
                System.debug('documentLinks='+documentLinks);
                    if (documentLinks != null && !documentLinks.isEmpty()) {
                        String linkId = documentLinks.get(0).ContentDocumentId;
                System.debug('linkId='+linkId);
                        List<ContentNote> notes = [SELECT id,Title,Content,LastModifiedDate FROM ContentNote WHERE id =: linkId];
                System.debug('notes='+notes);
                        if (notes != null && !notes.isEmpty()) {
                            String content = EncodingUtil.base64Decode(EncodingUtil.base64Encode(notes[0].content)).toString();
                            return new commonResponseDto(0, null, content);
                        }
                    }
                }                
            }
            return new commonResponseDto(40, MESSAGE, null);
        } catch (Exception e) {
            system.debug(Logginglevel.ERROR, 'システムエラー:' + e.getMessage());
            throw e;
        }
    }
    
    /**
    * 実行中ユーザーがバッチ実行ユーザーであるか
    * @return Boolean
    */
    public static List<User> getSystemAndManagerUsers() {
        List<Profile__mdt> profileList = [SELECT ProfileName__c, 
                                          DeveloperName FROM Profile__mdt 
                                          WHERE DeveloperName =: CommonConstantsUtil.SYSTEMADMIN
                                          OR DeveloperName =: CommonConstantsUtil.INTEGRATECLIADMIN];
        
        if (profileList != null && !profileList.isEmpty()) {
            List<String> profileNameList = new List<String>();
            for (Profile__mdt profile : profileList) {
                profileNameList.add(Profile.ProfileName__c);
            }
            List<User> users = [SELECT id, profile.name, name FROM user
                                WHERE profile.name IN : profileNameList AND IsActive = true];
            return users;
        }
        return null;
    }
}
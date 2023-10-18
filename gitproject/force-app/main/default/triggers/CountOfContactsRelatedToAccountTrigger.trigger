/*trigger contacttrigger on Contact (after insert,after update,after delete,after undelete) {
    if(trigger.isafter && (trigger.isinsert || trigger.isupdate || trigger.isundelete)){
        set<id> setid = new set<id>();
        for(contact con : trigger.new){
           setid.add(con.AccountId); 
        }
        list<Account> accl = [select id,name,(select id,firstname from contacts) from account where id = : setid];
            for(Account acc :accl){
                for(Contact cont :acc.contacts){
            system.debug('@@@@@@@@@@'+acc.Contacts.size());
          //  system.debug('@@@@@@@@@@'+acc.contacts());

                }}}
        if(trigger.isafter && trigger.isdelete){
          set<id> sett = new set<id>();
        for(contact con : trigger.old){
           sett.add(con.AccountId); 
        }  
        }  
    }

trigger CountOfContactsRelatedToAccount on Contact (after insert, after delete, after Undelete) {
    Set<Id> accId = new Set<Id>();
    if(Trigger.isInsert || Trigger.isUndelete){
        for(Contact con : Trigger.new)
        {
            system.debug('@@@@'+con);
            accId.add(con.AccountId);
                        system.debug('@@@@###'+con.AccountId);

        }
    }
    if(Trigger.isDelete){
        for(Contact con : Trigger.old){
                        system.debug('%%%%%%%%'+con);

            accId.add(con.AccountId);
                                    system.debug('**********'+accId);

        }
    }
    List<Account> accList = [Select Id,Name,Number_of_Contacts__c ,(Select id from contacts) from Account where Id IN : accId];
    system.debug('(((((((('+accList);
    for(Account acc :accList){
        acc.Number_of_Contacts__c = acc.contacts.size();
    }
    system.debug('update accList'+update accList);
    update accList;
}*/
trigger CountOfContactsRelatedToAccountTrigger on Contact (after insert, after delete, after undelete,after update) {
if(trigger.isafter && (trigger.isinsert || trigger.isupdate || trigger.isundelete)){
    ContactTriggerHandler.handle(trigger.new,null);}
    if(Trigger.isDelete){
            ContactTriggerHandler.handle(null,trigger.old);}

}
public with sharing class ContactController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String searchTerm, String accountFilter, String titleFilter, String departmentFilter) {
        String query = 'SELECT Id, Name, FirstName, LastName, Email, Phone, Title, Department, Account.Name ' +
                       'FROM Contact';
        
        List<String> conditions = new List<String>();
        
        if (String.isNotBlank(searchTerm)) {
            String searchPattern = '%' + String.escapeSingleQuotes(searchTerm) + '%';
            conditions.add('(FirstName LIKE \'' + searchPattern + '\' OR LastName LIKE \'' + searchPattern + '\')');
        }
        if (String.isNotBlank(departmentFilter)) {
            conditions.add('Department LIKE \'%' + String.escapeSingleQuotes(departmentFilter) + '%\'');
        }
        if (String.isNotBlank(accountFilter)) {
            conditions.add('Account.Name LIKE \'%' + String.escapeSingleQuotes(accountFilter) + '%\'');
        }
        if (String.isNotBlank(titleFilter)) {
            conditions.add('Title LIKE \'%' + String.escapeSingleQuotes(titleFilter) + '%\'');
        }
        
        if (!conditions.isEmpty()) {
            query += ' WHERE ' + String.join(conditions, ' AND ');
        }
        
        query += ' WITH SECURITY_ENFORCED LIMIT 50';
        
        return Database.query(query);
    }

    //Get unique values for filters
    @AuraEnabled(cacheable=true)
    public static List<String> getUniqueAccounts() {
        List<Contact> contacts = [SELECT Id, Account.Name FROM Contact WHERE Account.Name != null];
        List<String> accountNames = new List<String>();
        for (Contact c : contacts) {
            if(accountNames.isEmpty() || !accountNames.contains(c.Account.Name)) {
                accountNames.add(c.Account.Name);
            } else {
                System.debug('Duplicate Account Name: ' + c.Account.Name);
            }
        }
        return accountNames;
    }

    @AuraEnabled(cacheable=true)
    public static List<String> getUniqueTitles() {
        List<Contact> contactsTitles = [SELECT Id, Title FROM Contact WHERE Title != null];
        List<String> titles = new List<String>();
        for(Contact c : contactsTitles) {
            if(titles.isEmpty() || !titles.contains(c.Title)) {
                titles.add(c.Title);
            } else {
                System.debug('Duplicate Title: ' + c.Title);
            }
        }
        return titles;
    }

    @AuraEnabled(cacheable=true)
    public static List<String> getUniqueDepartments(){
            List<Contact> contactsDepartments = [SELECT Id, Department FROM Contact WHERE Department != null];
            List<String> departments = new List<String>();
            for(Contact c : contactsDepartments) {
                if(departments.isEmpty() || !departments.contains(c.Department)) {
                    departments.add(c.Department);
                } else {
                    System.debug('Duplicate Department: ' + c.Department);
                }
            }
            return departments;
    }
}
@isTest
private class ContactControllerTest {

    @TestSetup
    static void setup(){
        Account acc1 = new Account(
            Name = 'Test Account 1',
            Phone = '123-456-7890',
            Industry = 'Technology'
        );
        insert acc1;
        Account acc2 = new Account(
            Name = 'Test Account 2',
            Phone = '987-654-3210',
            Industry = 'Finance'
        );
        insert acc2;

        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(FirstName = 'Goku', LastName = 'Son', Department = 'Sales', Title = 'Manager', Email = 'goku.son@example.com', AccountId = acc1.Id));
        contacts.add(new Contact(FirstName = 'Vegeta', LastName = 'Prince', Department = 'Marketing', Title = 'Executive', Email = 'vegeta.prince@example.com', AccountId = acc2.Id));
        contacts.add(new Contact(FirstName = 'Bulma', LastName = 'Briefs', Department = 'Engineering', Title = 'Director', Email = 'bulma.briefs@example.com', AccountId = acc1.Id));
        contacts.add(new Contact(FirstName = 'Piccolo', LastName = 'Demon', Department = 'Sales', Title = 'Associate', Email = 'piccolo.demon@example.com', AccountId = acc2.Id));
        contacts.add(new Contact(FirstName = 'Krillin', LastName = 'Destructo', Department = 'Support', Title = 'Specialist', Email = 'krillin.destructo@example.com', AccountId = acc1.Id));
        insert contacts;
    }

    @isTest
    static void testGetContactsWithSearch(){
        Test.startTest();
        List<Contact> results = ContactController.getContacts('Goku', null, null, null);
        Test.stopTest();
        System.assertEquals(1, results.size(), 'Should return 1 contact matching search term "Goku"');
    }

    @isTest
    static void testContactsWithFilters(){
        Test.startTest();
        List<Contact> results = ContactController.getContacts('', 'Test Account 1', 'Manager', 'Sales');
        Test.stopTest();
        System.assertEquals(1, results.size(), 'Should return 1 contact matching filters');
    }

    @isTest
    static void testGetContactsWithNoResults(){
        Test.startTest();
        List<Contact> results = ContactController.getContacts('Gohan', null, null, null);
        Test.stopTest();
        System.assertEquals(0, results.size(), 'Should return 0 contacts for non-matching search term');
    }

    @isTest
    static void testGetUniqueAccounts(){
        Test.startTest();
        List<String> accounts = ContactController.getUniqueAccounts();
        Test.stopTest();
        System.assertEquals(2, accounts.size(), 'Should return 2 unique account names');
    }

    @isTest
    static void testGetUniqueTitles(){
        Test.startTest();
        List<String> titles = ContactController.getUniqueTitles();
        Test.stopTest();
        System.assertEquals(5, titles.size(), 'Should return 5 unique titles');
    }

    @isTest
    static void testGetUniqueDepartments(){
        Test.startTest();
        List<String> departments = ContactController.getUniqueDepartments();
        Test.stopTest();
        System.assertEquals(4, departments.size(), 'Should return 4 unique departments');
    }
}
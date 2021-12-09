public class ContactsDatatableController {
    List<Contact> contacts{get;set;}
 
    public ApexPages.StandardSetController stdSetController {
		get {
			if(stdSetController == null) {
				stdSetController = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id, LastName FROM Contact ORDER By Name LIMIT 100]));
				stdSetController.setPageSize(5);
			}
			return stdSetController;
		}
		set;
	}
    
    public List<Contact> getContacts() {
		contacts = new List<Contact>();
		for (Contact cont : (List<Contact>)stdSetController.getRecords())
			contacts.add(new Contact(Id = cont.Id, LastName = cont.LastName));

		return contacts;
	}

	public Integer pageNumber {
		get {
			return stdSetController.getPageNumber();
		}
		set;
	}

 	public void first() {
 		stdSetController.first();
 	}

 	public void last() {
 		stdSetController.last();
 	}

 	public void previous() {
 		stdSetController.previous();
 	}
    
 	public void next() {
 		stdSetController.next();
 	}
}
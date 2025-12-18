import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class ContactSearchManager extends NavigationMixin(LightningElement) {
    @track contacts = [];
    @track error;
    @track isLoading = false;
    searchTerm = '';
    accountFilter = '';
    titleFilter = '';
    departmentFilter = '';

    handleSearchChange(event) {
        this.searchTerm = event.target.value;
        this.searchContacts();
        const searchEvent = new CustomEvent('search', {
            detail: {search : this.searchTerm}
        });
        this.dispatchEvent(searchEvent);
    }

    handleAccountFilterChange(event) {
        this.accountFilter = event.target.value;
        this.searchContacts();
        const searchEvent = new CustomEvent('accountfilter', {
            detail: {accountFilter : this.accountFilter}
        });
        this.dispatchEvent(searchEvent);
    }

    handleTitleFilterChange(event) {
        this.titleFilter = event.target.value;
        this.searchContacts();
        const searchEvent = new CustomEvent('titlefilter', {
            detail: {titleFilter : this.titleFilter}
        });
        this.dispatchEvent(searchEvent);
    }
    
    handleDepartmentFilterChange(event) {
        this.departmentFilter = event.target.value;
        this.searchContacts();
        const searchEvent = new CustomEvent('departmentfilter', {
            detail: {departmentFilter : this.departmentFilter}
        });
        this.dispatchEvent(searchEvent);
    }

    searchContacts() {
        //Do not return values if fields are empty
        if(!this.searchTerm && !this.accountFilter && !this.titleFilter && !this.departmentFilter) {
            this.contacts = [];
            return;
        }
        this.isLoading = true;
        getContacts({
            searchTerm: this.searchTerm || '',
            accountFilter: this.accountFilter,
            titleFilter: this.titleFilter,
            departmentFilter: this.departmentFilter
        }).then(result => {
            this.contacts = result.map(contact => ({
                ...contact,
                detailUrl: '/lightning/r/Contact/' + contact.Id + '/view'
            }));
            this.error = undefined;
            this.isLoading = false;
        }).catch(error => {
            this.error = error;
            this.contacts = [];
        }).finally(() => {
            this.isLoading = false;
        });
    }

    handleClearSearch() {
        this.searchTerm = '';
        this.accountFilter = '';
        this.titleFilter = '';
        this.departmentFilter = '';
        this.contacts = [];
    }

    get hasContacts() {
        return this.contacts && this.contacts.length > 0;
    }

    getContactInitials(name) {
        const names = name.split(' ');
        if (names.length === 1) {
            return names[0].charAt(0);
        } else {
            return names[0].charAt(0) + names[1].charAt(0);
        }
    }
}
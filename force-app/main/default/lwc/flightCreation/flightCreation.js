import getTrip from '@salesforce/apex/FlightCreationController.getTripsByCountryName';
import getCountries from '@salesforce/apex/FlightCreationController.getCountries';
import createFlightByTouristAndTripIds from '@salesforce/apex/FlightCreationController.createFlightByTouristAndTripIds';
import { LightningElement, track, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class FlightCreation extends LightningElement {

    @api touristRecords = [];
    @track tripRecords = [];
    @track countryRecords = [];
    selectedTripName;
    selectedTouristName;
    selectedCountryName;
    flightName;

    @wire(getCountries)
    wiredCountryRecords({ error, data }) {
        if (data) {
            this.error = undefined;
            this.countryRecords = JSON.parse(JSON.stringify(data));
            console.log(this.countryRecords);
        } else if (error) {
            this.error = error;
            this.countryRecords = undefined;
        }
    }

    fetchTripByCounry() {
        getTrip({
            countryName : this.selectedCountryName
        })
        .then((result) => {
            this.tripRecords = JSON.parse(JSON.stringify(result));
            console.log('@@@ ' + this.tripRecords);
        })
        .catch((error) => {
            console.log(error);
        })
    }

    handleTrip(event) {
        const boxes = this.template.querySelectorAll('lightning-input');
        boxes.forEach(box => box.checked = event.target.name === box.name);
        this.selectedTripName = event.target.name;       
        console.log(this.selectedTripName);
    }

    handleTourist(event) {
        const boxes = this.template.querySelectorAll('lightning-input');
        boxes.forEach(box => box.checked = event.target.name === box.name);
        this.selectedTouristName = event.target.name;       
        console.log(this.selectedTouristName);
    }

    handleCountry(event) {
        const boxes = this.template.querySelectorAll('lightning-input');
        boxes.forEach(box => box.checked = event.target.name === box.name);
        this.selectedCountryName = event.target.name; 
        console.log(this.selectedCountryName);
        this.fetchTripByCounry();
    }

    handleClick(event) {
        this.createFlight();
    }

    createFlight() {
        createFlightByTouristAndTripIds({
            touristId: this.selectedTouristName,
            tripId : this.selectedTripName,
            name : this.flightName  
        })
        .then((result) => {
            this.showToast();
        })
        .catch((error) => {
            console.log(error);
        })
    }

    showToast() {
        const event = new ShowToastEvent({
            title: 'Success!',
            message: 'The flight has been created',
            variant: 'success'
        });
        this.dispatchEvent(event);
    }

    handleInputChange(event) {
        this.flightName = event.detail.value;
    }
}
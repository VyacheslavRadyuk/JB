import { LightningElement, track } from 'lwc';
import retrieveTouristsByTrip from '@salesforce/apex/RelatedDatatableController.getTouristsByTrip';

export default class RelatedDatatable extends LightningElement {
    
    selectedId;
    @track data;
    tripDataWithoutDuplicate = [];
    flightDataWithoutDuplicate = [];

    getFlightsAndTripsBySelectedTourist() {
        retrieveTouristsByTrip({
            selectedId: this.selectedId 
        })
        .then((result) => {
            console.log(result);
            this.data = result;
            let tripsWithDuplicates = [];
            let tripsWithoutDuplicates = [];
           
            tripsWithDuplicates = result.map(row => {return {tripName: row.tripName }});
            console.log(tripsWithDuplicates);

            tripsWithoutDuplicates = tripsWithDuplicates.reduce((unique, o) => {
                if(!unique.some(obj => obj.tripName === o.tripName)) {
                  unique.push(o);
                }
                return unique;
            },[]);
            console.log(tripsWithoutDuplicates);

            this.tripDataWithoutDuplicate = JSON.parse(JSON.stringify(tripsWithoutDuplicates));
            console.log(this.tripDataWithoutDuplicate);
        })
        .catch((error) => {
            console.log(error);
        })
    }

    handleAccountSelection(event){
        this.selectedId = event.detail;
        this.getFlightsAndTripsBySelectedTourist();
    }

    handleTrip(event) {
        const boxes = this.template.querySelectorAll('lightning-input');
        boxes.forEach(box => box.checked = event.target.name === box.name);
        const selectedTripName = event.target.name;       
        const dataBySelectedTrip = this.data.filter(item => item.tripName === selectedTripName);
        let availableFlights = [];

        availableFlights = dataBySelectedTrip.map(row => {return {flightName: row.flightName }});
        

        this.flightDataWithoutDuplicate = JSON.parse(JSON.stringify(availableFlights));
        console.log(this.flightDataWithoutDuplicate);
    }

    handleFlight(event) {
        const boxes = this.template.querySelectorAll('lightning-input');
        boxes.forEach(box => box.checked = event.target.name === box.name);
    }
}
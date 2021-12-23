import { LightningElement, wire, track } from 'lwc';
import getFieldNames from '@salesforce/apex/SObjectFieldNamesController.getFieldNames';
import getObjectName from '@salesforce/apex/SObjectFieldNamesController.getObjectName';

export default class SObjectFieldNames extends LightningElement {

    @track objectNames = [];
    selectedSObject = '';
    fieldNames = [];

    get options() {
        return this.objectNames;
    }
    
    @wire(getObjectName, {})
    wiredObjectNames({ error, data }) {
        if (data) {
            this.error = undefined;
            let datas = JSON.parse(JSON.stringify(data));
            let lstOption = [];
            for (var i = 0;i < datas.length;i++) {
                    lstOption.push({value: datas[i],label: datas[i]
                });
            }
            this.objectNames = lstOption;
            console.log('@@@@ ' + this.objectNames);
        } else if (error) {
            this.error = error;
            this.objectNames = undefined;
        }
    }

    handleChangeSobject(event) {
        this.selectedSObject = event.target.value;
        console.log('@@@ ' + this.selectedSObject);
        this.fetchFieldNamesBySObjectName();
    }

    fetchFieldNamesBySObjectName() {
        getFieldNames({
            objName : this.selectedSObject
        })
        .then((result) => {
            this.fieldNames = result;
            console.log('@@@ ' + this.fieldNames);
        })
        .catch((error) => {
            console.log(error);
        })
    }
}
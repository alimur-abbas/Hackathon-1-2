import { LightningElement ,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LearningRecordEditFormLwc extends LightningElement {
    @api recordId;
    @api objectApiName;

    handleSubmit(event){
        event.preventDefault();
        console.log('Event '+JSON.stringify(event.detail));
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success',
            message: 'Record Updated',
            variant: 'success'
        }));
    }
}
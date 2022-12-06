import { LightningElement, wire , track } from 'lwc';
import getTableData from '@salesforce/apex/GetAccountAndContactInfo.getData';

export default class WorkingWithWrapperCls extends LightningElement {
    @track tableData ;
    @track error; 
    @wire (getTableData) 
        getresult({error,data}){
            if(data){
                // data.forEach(element => {
                //     element.accountId =+element.accountId;
                    
                // });
                this.tableData = data;}
                else if(error){
                    this.error = error;
                    }
                }

    cols=[
        {label:'Account Name',fieldName:'Lurl',type:'url',typeAttributes:{label:{fieldName:'accountName'},target:'_self'}},
        {label:'Contact Name',fieldName:'contactName',type:'text'},
        {label:'Contact Email',fieldName:'email',type:'email'},
        {label:'Billing City',fieldName:'billingCity',type:'text'},
        {label:'Billing State',fieldName:'billingState',type:'text'}];
}
//if we are serializing the data in apex class then we need to use Json.parse() method to parse the data in and store it in a variable of array type.
({
    handleSubmit : function(cmp, event, helper) {
        event.preventDefault();       // stop the form from submitting
        const fields = event.getParam('fields');
        fields.Name = 'My Custom Last Name'; // modify a field
        cmp.find('myRecordForm').submit(fields);
    }
})
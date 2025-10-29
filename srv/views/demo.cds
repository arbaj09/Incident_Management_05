namespace Incident_Management.srv.views;
using { sap.capire.incidents as db } from '../../db/Schema';

define view detail as select from db.Incidents {
   key ID,
  customer,
  title,
  urgency,
  status,
  customer.name  as customer_name,
  customer.email as customer_email,
  customer.phone as customer_Number
};

define view IncidentCustomerAddress
  as select from db.Incidents 
{
   key ID as Incident_ID,
    title,
    status,
    urgency,

    customer.name as customer_name,
    customer.email as customer_email,
    customer.phone as customer_Number,

    customer.addresses.city as city,
    customer.addresses.postCode as PinCode,
    customer.addresses.streetAddress as streetAddress


    

  
};

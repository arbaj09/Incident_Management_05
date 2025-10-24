using { sap.capire.incidents as my } from '../db/Schema';

/**
 * Service used by support personell, i.e. the incidents' 'processors'.
 */
service ProcessorService { 


    entity Incidents as projection on my.Incidents;


    // with exclude  keyword you can hide fields
     
    // entity Incidents as projection on my.Incidents  excluding{
    //     status, urgency
    // };

    

    @readonly
    entity Customers as projection on my.Customers;
}

annotate ProcessorService.Incidents with @odata.draft.enabled ;





/**
 * Service used by administrators to manage customers and incidents.
 */
service AdminService {
    entity Customers as projection on my.Customers;
    entity Incidents as projection on my.Incidents;
    }

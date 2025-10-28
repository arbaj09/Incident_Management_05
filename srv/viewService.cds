using { Incident_Management.srv.views as Viewss } from './views/demo';


service ViewService {
entity IncidentDetails as projection on Viewss.IncidentCustomerAddress;
entity Details as projection on Viewss.detail;

}

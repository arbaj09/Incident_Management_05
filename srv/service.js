const cds = require('@sap/cds')
const { SELECT } = require('@sap/cds/lib/ql/cds-ql')
const UPDATE = require('@sap/cds/lib/ql/UPDATE')

module.exports = class ProcessorService extends cds.ApplicationService { init() {

  const { Incidents, Customers } = cds.entities('ProcessorService')

  this.before (['CREATE', 'UPDATE'], Incidents, async (req) => {
    console.log('Before CREATE/UPDATE Incidents', req.data)
  })
  this.after ('READ', Incidents, async (incidents, req) => {
    console.log('After READ Incidents', incidents)
  })
  this.before (['CREATE', 'UPDATE'], Customers, async (req) => {
    console.log('Before CREATE/UPDATE Customers', req.data)
  })
  this.after ('READ', Customers, async (customers, req) => {
    console.log('After READ Customers', customers)
  })

  this.on ('closeIncident', async (req) => {
 const { ID } = req.params[0];
 console.log('incident id ' , ID)
     // Get the current incident
    const incident = await SELECT.one.from(Incidents).where({ ID });
    if (!incident) return req.error(404, 'Incident not found');

    // Update the status
      await UPDATE(Incidents).set({ status_code: 'C' }).where({ ID });

     // Check if already closed
  if (incident.status_code === 'C') {
     req.reject(400, `Incident ${ID} is already closed`);
     return
  }  

      return req.info('Incident closed');
      
  })

  this.on('fillTitle', async(req)=>{
    const {ID} = req.params[0];
   const Incident  = await SELECT.one.from(Incidents).where({ID})
   if (!Incident.title) {
    await UPDATE(Incidents).set({ title: 'changed title'}).where({ID})
    return req.info(`Changed Title`)
   }
  }
)
  return super.init()
}}

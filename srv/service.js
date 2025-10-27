const cds = require('@sap/cds')

module.exports = class ProcessorService extends cds.ApplicationService { init() {

  // const { Incidents, Customers } = cds.entities('ProcessorService')

  const {Incidents, Customers} = this.entities;

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
  this.before("CREATE",Incidents,this.ChangeUrgencyDueToSubject);
  this.before("CREATE" ,Incidents, this.onVaildation)

  this.before("CREATE", Incidents, this.AutoFill)


  return super.init()



} 

ChangeUrgencyDueToSubject(req){
    let urgent = req.data.title?.match(/urgent/i)

    console.log("Uregency" , req.data)
    if (urgent) req.data.urgency_code = 'H'


  }

  onVaildation(req){
   const { title, status_code } = req.data
  if (!title) req.reject("Please Enter the Title")
  if (status_code !== 'N') req.reject("During Creation, Status Should be New")

  }

  AutoFill(req){
   if (!req.data.conversation) {
    req.data.conversation = []
  }
  req.data.conversation.push({
    message: 'New Incident Created test'
  })

  }


}

using ProcessorService as service from '../../srv/service';
using from '../../db/Schema';

annotate service.Incidents with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'customer',
                Value : customer_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : title,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Overview',
            ID : 'Overview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    ID : 'GeneratedFacet1',
                    Label : 'General Information',
                    Target : '@UI.FieldGroup#GeneratedGroup',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Details',
                    ID : 'Details',
                    Target : '@UI.FieldGroup#Details',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Conversession',
            ID : 'Conversession',
            Target : 'conversation/@UI.LineItem#Conversession',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Value : customer.name,
            Label : 'Customer',
        },
        {
            $Type : 'UI.DataField',
            Value : status.descr,
            Label : 'Status',
            Criticality : status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : urgency.descr,
            Label : 'Urgency',
        },
    ],
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ],
    UI.HeaderInfo : {
        TypeName : '',
        TypeNamePlural : '',
        TypeImageUrl : 'sap-icon://alert',
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
    },
    UI.FieldGroup #Details : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
            },
        ],
    },
);

annotate service.Incidents with {
    customer @(
        Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Customers',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : customer_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
        ],
    },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Incidents with {
    status @(
        Common.Label : 'Status',
        Common.ValueListWithFixedValues : true,
        Common.Text : status.descr,
    )
};

annotate service.Incidents with {
    urgency @(
        Common.Label : 'Urgency',
        Common.ValueListWithFixedValues : true,
        Common.Text : urgency.descr,
    )
};

annotate service.Status with {
    code @Common.Text : descr
};

annotate service.Urgency with {
    descr @Common.Text : code
};

annotate service.Urgency with {
    code @Common.Text : descr
};

annotate service.Incidents.conversation with @(
    UI.LineItem #Conversession : [
        {
            $Type : 'UI.DataField',
            Value : author,
            Label : 'Author',
        },
        {
            $Type : 'UI.DataField',
            Value : message,
            Label : 'message',
        },
        {
            $Type : 'UI.DataField',
            Value : timestamp,
            Label : 'Date',
        },
    ]
);


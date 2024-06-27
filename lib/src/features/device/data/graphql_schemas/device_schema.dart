const String getDeviceQuery = """
    query getDevice(\$input: GetDeviceInput!) {
            getDevice(input: \$input) {
              ... on Terminal {
                address
                approvalsCount
                id
                location {
                  lat
                  lon
                }
                notes
                registrationDate
                status
                user {
                  id
                }
              }
            }
          }
""";

const String listDevicesQuery = """
     query listDevices(\$input: ListDevicesInput!){
    listDevices(input: \$input){
      devices {
        ... on Terminal {
          id
          address
          notes
          registrationDate
        }
      }
      total
    }
  }
""";

const String createDeviceMutation = """
    mutation createDevice(\$input: CreateDeviceInput!) {
        createDevice(input: \$input) {
          ... on Terminal {
            address
            approvalsCount
            id
            location {
              lat
              lon
            }
            notes
            registrationDate
            status
            user {
              id
              username
              point
            }
          }
        }
  }
""";

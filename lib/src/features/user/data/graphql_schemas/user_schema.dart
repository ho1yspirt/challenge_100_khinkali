String getUserQuery({
  bool withId = true,
  bool withUsername = true,
  bool withAvatar = true,
  bool withEmail = true,
  bool withGroupName = true,
  bool withJoinDate = true,
  bool withPhoneNumber = true,
  bool withPoints = true,
  bool withStatus = true,
}) {
  return """
          query getUser(\$input: GetUserInput!) {
            getUser(input: \$input) {
              ${withId ? 'id' : ''}
              ${withUsername ? 'username' : ''}
              ${withAvatar ? 'avatar' : ''}
              ${withEmail ? 'email' : ''}
              ${withGroupName ? 'groupName' : ''}
              ${withJoinDate ? 'joinDate' : ''}
              ${withPhoneNumber ? 'phoneNumber' : ''}
              ${withPoints ? 'point' : ''}
              ${withStatus ? 'status' : ''}
            }
          }
      """;
}

String listUsersQuery({
  bool withId = true,
  bool withUsername = true,
  bool withAvatar = true,
  bool withEmail = true,
  bool withGroupName = true,
  bool withJoinDate = true,
  bool withPhoneNumber = true,
  bool withPoints = true,
  bool withStatus = true,
}) {
  return """
          query listUsers(\$input: ListUsersInput!){
            listUsers(input: \$input) {
              users {
                ${withId ? 'id' : ''}
                ${withUsername ? 'username' : ''}
                ${withAvatar ? 'avatar' : ''}
                ${withEmail ? 'email' : ''}
                ${withGroupName ? 'groupName' : ''}
                ${withJoinDate ? 'joinDate' : ''}
                ${withPhoneNumber ? 'phoneNumber' : ''}
                ${withPoints ? 'point' : ''}
                ${withStatus ? 'status' : ''}
              }
            }
          }
      """;
}

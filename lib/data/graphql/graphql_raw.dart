class GraphQLRaw {
  static const createAccount = r'''
mutation createAccount($accountInput: CreateAccountInput!) {
  createAccount(accountInput: $accountInput) {
    id
    org_id
    email_local_part
    password
    datetime
    secondary_email_id
    author_user_id
  }
}
''';

  static const getOrgById = r'''
query getOrgById($id: ID!) {
  getOrgById(id: $id) {
    id
    name
    email_domain_part
    datetime
    email_id
    mode
    client_api_key
  }
}
''';

  static const checkOTPValidity = r'''
mutation checkOTPValidity($code: String) {
  checkOTPValidity(code: $code) {
    id
    name
    email_domain_part
    datetime
    email_id
    mode
    client_api_key
    user_id
  }
}
''';

  static const getAccount = r'''
query getAllAccounts($email_local_part: String, $password: String) {
  getAllAccounts(email_local_part: $email_local_part, password: $password) {
    id
    org_id
    secondary_email_id
  }
}
''';

  static const getEmailsByAccountId = r'''
query getEmailsByAccountId($account_id: ID!) {
  getEmailsByAccountId(account_id:$account_id) {
    id
    to_account_id
    from_name
    from_email_id
    subject
    body
    snippet
    is_html
    datetime
    org_id
    author_user_id
  }
}
''';
}

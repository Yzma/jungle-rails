
describe('User Registration', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:3000/');
  });

  it("should login", () => {
    cy.visit('http://127.0.0.1:3000/login');

    cy.get('#email').type('uniqueemailaddress@uniqueemailaddress.com');
    cy.get('#password').type('valid_password');
    
    cy.get('.btn').click(); // Login button
    
    cy.url().should('eq', 'http://127.0.0.1:3000/');
    cy.contains("Logout");

  });

  // it("should create a new account and login", () => {
  //   cy.visit('http://127.0.0.1:3000/signup');

  //   cy.get('#user_name').type('First Last');
  //   cy.get('#user_email').type('othertest@test.com');
  //   cy.get('#user_password').type('valid_password');
  //   cy.get('#user_password_confirmation').type('valid_password');
    
  //   cy.get('.btn').click(); // Create Account button
    
  //   cy.url().should('eq', 'http://127.0.0.1:3000/');
  //   cy.contains("Logout");

  // });

});


describe('Add item to cart', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:3000/');
  });

  it("should add an item to the cart and update the counter", () => {
    cy.get('.products > :nth-child(1) > div > form > button').click({force: true});
    cy.contains('My Cart (1)');
  });

  it("should add item to the cart and go to cart page to verify it's added", () => {
    cy.get('.products > :nth-child(1) > div > form > button').click({force: true});
    
    cy.visit('http://127.0.0.1:3000/cart');

    cy.contains('My Cart');
  });

});

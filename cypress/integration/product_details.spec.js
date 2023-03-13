
describe('Product page', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:3000/');
  });

  it("should navigate to the first product on the list", () => {
    cy.get('.products > :nth-child(1) > a').click();
  });

});

Your friend wants to open a small convenience store in Berlin and she asked for your help to build the system for the cash register.

At first the shop will only sell following items:

- Beer 1.50€
- Chips 2.00€
- Chocolate 3.10€
- Soda 2.50€
- Sandwich 4.00€

To boost sales in the first couple of months your friend came up with some rules to offer discounts:

- If someone buys 1 chocolate, they can get another one for free.
- For every 3 beers bought, the customer gets a 10% discount on each one of them.
- If someone buys a sandwich and a soda, they can get a chocolate for free.
- During happy hour (17h00-19h00) beer and soda is only half price

Here are a few examples:

- 4 beers and 2 chips outside of happy hour: 9.55€
- 4 chocolates and 1 beer during happy hour: 6.95€
- 1 sandwich, 1 soda, and 1 chocolate outside of happy hour: 6.50€

Keep in mind, however, that your friend changes her mind often, and will definitely change the rules at some point.

Your friend came up with the following idea / sample code:

```
rules = [...]
items = [...]

cart = MyStore::ShoppingCart.new(items)
register = MyStore::CashRegister.new(rules)
total = register.calculate_total(cart)
```

But isn’t sure about it, and trusts you to come up with the right solution.

Additional notes:

* You can use the programming language/framework of your choice.
* Feel free to come up with a completely different solution, creativity is encouraged.
* Please document design decisions in an accompanying README.
* Please provide at least unit-level tests.
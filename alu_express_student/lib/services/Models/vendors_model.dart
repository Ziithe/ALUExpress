class Vendors {
  String imageUrl;
  String name;
  String description;
  String price;

  Vendors({
    this.imageUrl,
    this.name,
    this.description,
    this.price,
  });
}

List<Vendors> vendors = [
  Vendors(
      imageUrl: 'assets/tacos.jpg',
      price: 'RWF 700 - 5000',
      name: 'Meze Fresh',
      description:
          'Specialties include Burittos, Assorted Sandwiches, Wraps, Buritto Bowls etc'),
  Vendors(
      imageUrl: 'assets/bkg.jpg',
      price: 'RWF 300 - 3000',
      name: 'Divine Catering',
      description:
          'Specialties include Salads (Garden, Beet Root and Greek), Stir Fry Meals, Stews, Rice, Chips, Beef, Fish, Light Snacks etc'),
  Vendors(
      imageUrl: 'assets/sandwich.jpg',
      price: 'RWF 500 - 3000',
      name: 'Avo Foods',
      description:
          'Specialties include light snacks and drinks, burgers, rolex, sandwiches (cheese and chicken), donughts, hot and cold drinks etc'),
  Vendors(
      imageUrl: 'assets/jollof.jpg',
      price: 'RWF 1500 - 300',
      name: 'Wazobia Chops',
      description:
          'Specialties include Jollof Rice, Spicy wings and beef, vegetable soup, plantain, puff puff and small chops, etc'),
  Vendors(
      imageUrl: 'assets/juice.jpg',
      price: 'RWF 1500 - 3000',
      name: 'Scholars Coffee',
      description:
          'Specialties include Lattes, Cappuccino, Expresso, Iced Tea, Iced Coffee, Juice, Smoothies, Milkshakes, Pizzas, Cakes, Donughts etc')
];

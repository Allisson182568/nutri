class Product {
  final int id, price;
  final String title, description, image;

  Product({required this.id, required this.price, required this.title, required this.description, required this.image});
}

// list of products
// for our demo
List<Product> products = [
  Product(
    id: 1,
    price: 56,
    title: "Panquecas de cenoura fit",
    image: "imagens/pratos/panqueca_cenoura.png",
    description:
    "Ingredientes\n \n1/2 cenoura crua picada\n1 xícara de chá de farinha integral de aveia\n1 ovo\n1 clara\nCanela a gosto\nEssência de baunilha a gosto (opcional)\n1 colher de café de fermento\n \nModo de preparo\n \n1. Em um liquidificador, adicione todos os ingredientes e bata até incorporar e formar uma massa.\n2.Esquente uma frigideira antiaderente e despeje uma concha da massa.\n3.Deixe dourar e depois vire para dourar o outro lado.\n4.Repita o processo até a massa acabar.\n5.Agora é só servir. Bom apetite. ",
  ),
  Product(
    id: 2,
    price: 68,
    title: "Panqueca de aveia",
    image: "imagens/pratos/panqueca_aveia.png",
    description:
    "Ingredientes\n \n1 xícara de aveia em flocos finos ou farinha de aveia\n1 xícara de água\n2 colheres de sopa de melado\n1 colher de sopa de farinha de linhaça\n1 colher de chá de fermento químico em pó\n \nModo de preparo\n \n1.Coloque todos os ingredientes no liquidificador, com exceção do fermento, e bata até ficar homogêneo. Se você estiver usando farinha de aveia, pode misturar todos os ingredientes manualmente\n2.Acrescente o fermento por último e misture delicadamente\n3.Aqueça uma frigideira antiaderente em fogo baixo. Espalhe um pouco da massa e tampe para abafar e já começar a assar o outro lado\n4.Verifique se está bem assada e vire para assar o outro lado até dourar. Tampe novamente para abafar\n5.Repita o processo até terminar a massa\n6.Sirva com o acompanhamento de sua preferência (mel, frutas, geleias, castanhas)",
  ),
  Product(
    id: 3,
    price: 39,
    title: "Chips assado de batata doce e alecrim",
    image: "imagens/pratos/ships_batata_doce.png",
    description:
    "Lista de ingredientes\n \n3 batatas-doces\nAzeite de oliva\nSal e pimenta a gosto\nAlecrim a gosto\n \nModo de preparo\n \n1.Lave as batatas\n2.Com o auxílio de um mandolin, corte-as, com casca, em rodelas bem fininhas\.3.Ajeite as fatias em uma assadeira coberta com silpat ou papel-manteiga e untada com azeite\n4.Tempere com sal e pimenta, regue com um fio de azeite e complete com o alecrim\n5.Leve ao forno preaquecido a 200° por 20 minutos ou até as fatias ficarem douradas\n6.O tempo pode variar de um forno para outro. Quanto mais fininhas forem as fatias, mais rápido elas assam\n7.Retire do forno e deixe esfriar uns cinco minutinhos antes de servir porque assim elas ficam bem crocantes",
  ),
  Product(
    id: 4,
    price: 56,
    title: "Pizza low carb com massa de brócolis",
    image: "imagens/pratos/pizza_brocolis.png",
    description:
    "Ingredientes Massa\n \n1 brócolis inteiro (daquele durinho, também chamado de chinês) ou 1 couve flor\n1 clara\nsal e pimenta do reino à gosto.\n \nIngredientes recheio:\n \n380g de peito de frango cozido e desfiado\n1/2 xícara de molho de tomate\n2 colheres de sopa (50g) de requeijão light\n1 tomate grande cortado em rodelas\nsal e pimenta do reino à gosto\n1 cebola cortada em cubinhos\n \nModo de Preparo\n \n1.Corte o brócolis, aproveitando os talos também. Cozinhe-o, de preferencia no vapor.\n2.Amasse com um garfo ou triture com o mixer até o brócolis se desmanchar.\n3.Esprema o conteúdo em uma peneira para tirar todo o excesso de líquido.\n4.Deixe esfriar um pouco e junte o ovo, misturando tudo.\n5.Despeje em uma forma de pizza redonda e leve ao forno até a massa secar e endurecer. (aproximadamente 25 minutos)\n6.Refogue a cebola, o frango e o molho de tomate, temperando-os.\n7.Monte a pizza: coloque o molho de frango sobre a massa, rodelas de tomate e despeje o requeijão por cima de tudo.\n8.Leve ao forno para aquecer. ",
  ),


];
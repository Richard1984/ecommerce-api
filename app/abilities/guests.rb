Canard::Abilities.for(:guest) do
  can [:create], User

  # L'ordine e' importante, non so quale linea va prima
  cannot :manage, [Category, Product, Cart, List, Review, Vote]
  can :read, [Review, Vote, Category, Product]

end

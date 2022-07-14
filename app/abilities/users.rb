Canard::Abilities.for(:user) do
  can :manage, [User, Cart, List, Review, Vote], id: user.id # DA PROVARE, NON SO SE NON MI FA CREARE LE COSE
  can [:read, :create], Order, user_id: user.id
  can :read, [Review, Vote, Category, Product]
  
  cannot [:create, :update, :destroy], [Category, Product]
  cannot [:update], [Order]
end

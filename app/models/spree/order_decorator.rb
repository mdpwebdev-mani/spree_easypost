Spree::Order.class_eval do

    self.state_machine.after_transition(
      to: :complete,
      do: :update_shipments,
    )
    
    def update_shipments
      updater.update_shipments
    end


end

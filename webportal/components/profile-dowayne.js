import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  gameApi: service(),
  flashMessages: service(),
  router: service(),

   actions: {
      AcknowledgeMarque(id) {
        let api = this.gameApi;
        api.requestOne('AcknowledgeMarque', { name: id }, null)
            .then( (response) => {
                if (response.error) {
                    return;
                }
                this.router.transitionTo('char',response.name);
                this.flashMessages.success('Marque acknowledged!');
            });
       },

      InitMarque(id) {
        let api = this.gameApi;
        api.requestOne('InitMarque', { name: id }, null)
            .then( (response) => {
                if (response.error) {
                    return;
                }
                this.router.transitionTo('char',response.name);
                this.flashMessages.success('Marque started!');
            });
      }
   }

});

import { computed } from '@ember/object';
import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

export default Controller.extend({
  gameApi: service(),
  flashMessages: service(),
  router: service(),
  chars: computed('model{courtesans,titles}', function () {
        let titles = this.get('model.titles');
        let courtesans = this.get('model.courtesans');
        let chars = [];
        courtesans.forEach(function(char_fields) {
            let char = [];
            titles.forEach(function(title) {
                let field = char_fields[title];
                char.push(field);
            });
            chars.push(char);
        });
        return chars;
    }),

    actions: {
      AcknowledgeMarque(id) {
        let api = this.gameApi;
        api.requestOne('AcknowledgeMarque', { name: id }, null)
            .then( (response) => {
                if (response.error) {
                    return;
                }
                this.router.transitionTo('char', response.name);
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

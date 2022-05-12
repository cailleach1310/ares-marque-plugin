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
});

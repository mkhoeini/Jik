var Foxie, HomePage, Main, MusicPlayer, Ribbon;

Foxie = require('foxie');

Ribbon = require('./Ribbon/Ribbon');

HomePage = require('./HomePage');

MusicPlayer = require('./MusicPlayer');

module.exports = Main = (function() {
  function Main(model) {
    this.model = model;
    this.el = Foxie('.master').putIn(document.body);
    this.inside = Foxie('.master-inside').moveZTo(100);
    this.ribbon = new Ribbon(this, ['home', 'artist', 'album', 'song', 'video']);
    this.inside.putIn(this.el);
    this.homePage = new HomePage(this, this.ribbon.getPage(0));
    this.homePage = new HomePage(this, this.ribbon.getPage(1));
    this.homePage = new HomePage(this, this.ribbon.getPage(2));
    this.homePage = new HomePage(this, this.ribbon.getPage(3));
    this.homePage = new HomePage(this, this.ribbon.getPage(4));
    this.musicPlayer = new MusicPlayer(this);
  }

  return Main;

})();

/*
//@ sourceMappingURL=Main.map
*/
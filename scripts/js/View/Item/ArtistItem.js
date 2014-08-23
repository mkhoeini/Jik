var ArtistItem, Foxie, Item,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Foxie = require('Foxie');

Item = require('../Item');

module.exports = ArtistItem = (function(_super) {
  __extends(ArtistItem, _super);

  function ArtistItem(mainView, parentNode, page, data) {
    this.mainView = mainView;
    this.parentNode = parentNode;
    this.page = page;
    ArtistItem.__super__.constructor.apply(this, arguments);
    this.hammer.on('tap', (function(_this) {
      return function(arg) {
        return console.log('artist');
      };
    })(this));
  }

  return ArtistItem;

})(Item);

/*
//@ sourceMappingURL=ArtistItem.map
*/

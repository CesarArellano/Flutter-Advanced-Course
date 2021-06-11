const BandModel = require('./band-model');

class BandsModel {
  constructor() {
    this.bands = [];
  }

  addBand(band = new BandModel()) {
    this.bands.push( band );
  }

  getBands() {
    return this.bands;
  }

  deleteBand(id = '') {
    this.bands = this.bands.filter( band => band.id !== id );
    return this.bands;
  }

  voteBand( id = '' ) {
    this.bands = this.bands.map( (band) => {
      if (band.id === id) {
        band.votes++;
        return band;
      } else {
        return band;
      }
    });
  }
}

module.exports = BandsModel;
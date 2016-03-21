var TruthinessScore = React.createClass({
  // shouldComponentUpdate: function(nextProps, nextState) {
  //   return nextProps.truthiness !== this.props.truthiness;
  // },
  // componentWillReceiveProps: function() {
  //   this.setState({
  //     truthIncrease: nextProps.truthiness > this.props.truthiness
  //   });
  // },
  // componentWillUpdate: function() {
  //   if(this.state.truthIncrease == true) {
  //     React.findDOMNode(this).classList.add("increase-truthiness-score");
  //   } else {
  //     React.findDOMNode(this).classList.add("decrease-truthiness-score");
  //   }
  // },
  // componentDidUpdate: function() {
  //   var animationTest = React.findDOMNode(this);
  //   setTimeout(function(){
  //    animationTest.classList.remove("increase-truthiness-score");
  //      animationTest.classList.remove("decrease-truthiness-score");
  //   }, 1000);
  // },
  render: function() {
    return (
      <div className="fact-box-score">
        <span className="short-cat-name">
          TRU
        </span>
        <span className="full-cat-name">
          TRUTHINESS
        </span>
        <span>
          {this.props.truthiness}
        </span>
      </div>
    );
  }
});

var PopularityScore = React.createClass({
  // shouldComponentUpdate: function(nextProps, nextState) {
  //   return nextProps.popularity !== this.props.popularity;
  // },
  render: function() {
    return (
      <div className="fact-box-score">
        <span className="short-cat-name">
          POP
        </span>
        <span className="full-cat-name">
          POPULARITY
        </span>
        <span>
          {this.props.popularity}
        </span>
      </div>
    );
  }
});

var FactCategory = React.createClass({
  // shouldComponentUpdate: function(nextProps, nextState) {
  //   return nextProps.category !== this.props.category;
  // },
  render: function() {
    return (
      <div className="fact-box-score">
        <span className="short-cat-name">
          CAT
        </span>
        <span className="full-cat-name">
          CATEGORY
        </span>
        <span>
          {this.props.category}
        </span>
      </div>
    );
  }
});

var FactTitle = React.createClass({
  // shouldComponentUpdate: function(nextProps, nextState) {
  //   return nextProps.title !== this.props.title;
  // },
  render: function() {
    return (
        <p className="fact-name">
            {this.props.title}
        </p>
    );
  }
});


var FactLink = React.createClass({
  loadFactFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {data: {title: this.props.title, truthiness: this.props.truthiness, popularity: this.props.popularity, category: this.props.category}};
  },
  componentDidMount: function() {
    this.loadFactFromServer();
    setInterval(this.loadFactFromServer, 5000);
  },
  render: function() {
    return (
      <div>
        <a href={this.props.link} className="fact-boxes">
          <FactTitle title={this.state.data.title} />
          <TruthinessScore truthiness={this.state.data.truthiness} />
          <PopularityScore popularity={this.state.data.popularity} />
          <FactCategory category={this.state.data.category} />
        </a>
      </div>
    );
  }
});

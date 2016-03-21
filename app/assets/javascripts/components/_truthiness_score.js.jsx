var TruthinessScore = React.createClass({
  loadScoreFromServer: function() {
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
    return {data: {truthiness: this.props.truthiness}, truthIncrease: true};
  },
  componentDidMount: function() {
    this.loadScoreFromServer();
    setInterval(this.loadScoreFromServer, this.props.pollInterval);
  },
  shouldComponentUpdate: function(nextProps, nextState) {
    return nextState.data.truthiness !== this.state.data.truthiness;
  },
  componentWillReceiveProps: function() {
    this.setState({
      truthIncrease: nextState.truthIncrease > this.truthIncrease
    });
  },
  componentWillUpdate: function() {
    if(this.state.truthIncrease == true) {
      React.findDOMNode(this).classList.add("increase-truthiness-score");
    } else {
      React.findDOMNode(this).classList.add("decrease-truthiness-score");
    }
  },
  componentDidUpdate: function() {
    var animationTest = React.findDOMNode(this);
    setTimeout(function(){
       animationTest.classList.remove("increase-truthiness-score");
       animationTest.classList.remove("decrease-truthiness-score");
    }, 1000);
  },
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
          {this.state.data.truthiness}
        </span>
      </div>
    );
  }
});

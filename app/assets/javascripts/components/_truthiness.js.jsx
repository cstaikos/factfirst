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
    return {data: {score: this.props.score}, scoreIncrease: true};
  },
  componentDidMount: function() {
    this.loadScoreFromServer();
    setInterval(this.loadScoreFromServer, this.props.pollInterval);
  },
  shouldComponentUpdate: function(nextProps, nextState) {
    return nextState.data.score !== this.state.data.score;
  },
  componentWillReceiveProps: function() {
    this.setState({
      scoreIncrease: nextState.scoreIncrease > this.scoreIncrease
    });
  },
  componentWillUpdate: function() {
    if(this.state.scoreIncrease == true) {
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
      <span>
        {this.state.data.score}
      </span>
    );
  }
});

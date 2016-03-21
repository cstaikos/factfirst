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
    return {data: []};
  },
  componentDidMount: function() {
    this.loadScoreFromServer();
    setInterval(this.loadScoreFromServer, this.props.pollInterval);
  },
  shouldComponentUpdate: function(nextProps, nextState) {
    return nextState.data.score !== this.state.data.score;
  },
  componentWillUpdate: function() {
    React.findDOMNode(this).classList.add("new-truthiness-score");
  },
  componentDidUpdate: function() {
    var animationTest = React.findDOMNode(this);
    setTimeout(function(){
       animationTest.classList.remove("new-truthiness-score");
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

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
    return {data: {score: this.props.score}, increase: true};
  },
  componentDidMount: function() {
    this.loadScoreFromServer();
    setInterval(this.loadScoreFromServer, this.props.pollInterval);
  },
  shouldComponentUpdate: function(nextProps, nextState) {
    return nextState.data.score !== this.state.data.score;
  },
  componentWillReceiveProps: function(nextProps, nextState) {
    if(nextState.data.score > this.state.data.score) {
      this.setState({increase: true});
    } else if(nextState.data.score < this.state.data.score) {
      this.setState({increase: false});
    }
  },
  componentWillUpdate: function() {
    React.findDOMNode(this).classList.add("change-truthiness-score");
    // NOTE: This is not working properly. The previous function does not increase state. The idea was to have red for decrease, green for increase.
    // Will revisit when React workflow is improved.
    // if(this.state.increase == true) {
    //   React.findDOMNode(this).classList.add("increase-truthiness-score");
    // } else {
    //   React.findDOMNode(this).classList.add("decrease-truthiness-score");
    // }
  },
  componentDidUpdate: function() {
    var animationTest = React.findDOMNode(this);
    setTimeout(function(){
       animationTest.classList.remove("change-truthiness-score");
      //  animationTest.classList.remove("decrease-truthiness-score");
    }, 3000);
  },
  render: function() {
    return (
      <span>
        {this.state.data.score}
      </span>
    );
  }
});

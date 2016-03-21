var PopularityScore = React.createClass({
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
    return {data: {popularity: this.props.popularity}};
  },
  componentDidMount: function() {
    this.loadScoreFromServer();
    setInterval(this.loadScoreFromServer, this.props.pollInterval);
  },
  shouldComponentUpdate: function(nextProps, nextState) {
    return nextState.data.popularity !== this.state.data.popularity;
  },
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
          {this.state.data.popularity}
        </span>
      </div>
    );
  }
});

var FactCategory = React.createClass({
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
    return {data: {category: this.props.category}};
  },
  componentDidMount: function() {
    this.loadScoreFromServer();
    setInterval(this.loadScoreFromServer, this.props.pollInterval);
  },
  shouldComponentUpdate: function(nextProps, nextState) {
    return nextState.data.category !== this.state.data.category;
  },
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
          {this.state.data.category}
        </span>
      </div>
    );
  }
});

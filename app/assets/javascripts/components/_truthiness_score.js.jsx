// var TruthinessScore = React.createClass({
//   shouldComponentUpdate: function(nextProps, nextState) {
//     return nextProps.truthiness !== this.props.truthiness;
//   },
//   componentWillReceiveProps: function() {
//     this.setState({
//       truthIncrease: nextProps.truthiness > this.props.truthiness
//     });
//   },
//   componentWillUpdate: function() {
//     if(this.state.truthIncrease == true) {
//       React.findDOMNode(this).classList.add("increase-truthiness-score");
//     } else {
//       React.findDOMNode(this).classList.add("decrease-truthiness-score");
//     }
//   },
//   componentDidUpdate: function() {
//     var animationTest = React.findDOMNode(this);
//     setTimeout(function(){
//      animationTest.classList.remove("increase-truthiness-score");
//        animationTest.classList.remove("decrease-truthiness-score");
//     }, 1000);
//   },
//   render: function() {
//     return (
//       <div className="fact-box-score">
//         <span className="short-cat-name">
//           TRU
//         </span>
//         <span className="full-cat-name">
//           TRUTHINESS
//         </span>
//         <span>
//           {this.props.truthiness}
//         </span>
//       </div>
//     );
//   }
// });
